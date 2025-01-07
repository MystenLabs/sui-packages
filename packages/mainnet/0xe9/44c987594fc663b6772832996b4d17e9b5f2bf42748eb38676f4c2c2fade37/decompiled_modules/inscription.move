module 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription {
    struct INSCRIPTION has drop {
        dummy_field: bool,
    }

    struct InscriptionData has store, key {
        id: 0x2::object::UID,
        total_inscription: u64,
    }

    struct Fee has store, key {
        id: 0x2::object::UID,
        inscribe_sui20_fee: u64,
        inscribe_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct InscriptionItem has store {
        inscription_id: u64,
        inscription: 0x1::string::String,
    }

    struct InscriptionSui20 has store {
        p: 0x1::string::String,
        op: 0x1::string::String,
        tick: 0x1::string::String,
        max: u64,
        amt: u64,
        lim: u64,
        current_mint: u64,
        uri: 0x1::string::String,
        inscription: 0x1::string::String,
        deployer: address,
    }

    struct InscribeEvent has copy, drop {
        inscription_id: u64,
        object_id: 0x2::object::ID,
    }

    struct InscriptionSui20DeployEvent has copy, drop {
        module_id: address,
        share_id: 0x2::object::ID,
        tick: 0x1::string::String,
        max: u64,
        amt: u64,
        lim: u64,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        deployer: address,
    }

    struct Sui20MintEvent has copy, drop {
        tick: 0x1::string::String,
        current_mint: u64,
    }

    public entry fun deploy_sui20(arg0: &mut InscriptionData, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::bytes(&arg2);
        assert!(0x1::vector::length<u8>(v0) == 4 || 0x1::vector::length<u8>(v0) == 3, 0);
        assert!(arg5 <= arg3, 0);
        assert!(!0x2::dynamic_field::exists_with_type<0x1::string::String, InscriptionSui20>(&arg0.id, arg2), 0);
        let v1 = InscriptionSui20{
            p            : 0x1::string::utf8(b"sui-20"),
            op           : 0x1::string::utf8(b"deploy"),
            tick         : arg2,
            max          : arg3,
            amt          : arg4,
            lim          : arg5,
            current_mint : 0,
            uri          : arg6,
            inscription  : arg9,
            deployer     : 0x2::tx_context::sender(arg10),
        };
        0x2::dynamic_field::add<0x1::string::String, InscriptionSui20>(&mut arg0.id, arg2, v1);
        let v2 = InscriptionSui20DeployEvent{
            module_id   : arg1,
            share_id    : arg7,
            tick        : arg2,
            max         : arg3,
            amt         : arg4,
            lim         : arg5,
            uri         : arg6,
            description : arg8,
            deployer    : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<InscriptionSui20DeployEvent>(v2);
    }

    public fun get_sui20_fee(arg0: &mut Fee) : u64 {
        arg0.inscribe_sui20_fee
    }

    public fun get_total_inscription(arg0: &mut InscriptionData) : u64 {
        arg0.total_inscription
    }

    fun init(arg0: INSCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<INSCRIPTION>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = InscriptionData{
            id                : 0x2::object::new(arg1),
            total_inscription : 0,
        };
        0x2::transfer::share_object<InscriptionData>(v0);
        let v1 = Fee{
            id                 : 0x2::object::new(arg1),
            inscribe_sui20_fee : 200000000,
            inscribe_fee       : 200000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            admin              : @0xd46c4e98e10a37aaffc146dce85fd7c39323dcb7c508817413506572d076b279,
        };
        0x2::transfer::share_object<Fee>(v1);
    }

    public entry fun inscribe(arg0: &mut InscriptionData, arg1: &mut Fee, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.inscribe_fee, 0);
        assert!(!0x2::dynamic_field::exists_with_type<0x2::object::ID, InscriptionItem>(&arg0.id, arg3), 0);
        let v0 = InscriptionItem{
            inscription_id : arg0.total_inscription + 1,
            inscription    : arg4,
        };
        0x2::dynamic_field::add<0x2::object::ID, InscriptionItem>(&mut arg0.id, arg3, v0);
        arg0.total_inscription = arg0.total_inscription + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = InscribeEvent{
            inscription_id : arg0.total_inscription,
            object_id      : arg3,
        };
        0x2::event::emit<InscribeEvent>(v1);
    }

    public entry fun inscribe_sui20(arg0: &mut InscriptionData, arg1: &mut Fee, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.inscribe_sui20_fee, 0);
        assert!(!0x2::dynamic_field::exists_with_type<0x2::object::ID, InscriptionItem>(&arg0.id, arg3), 0);
        assert!(0x2::dynamic_field::exists_with_type<0x1::string::String, InscriptionSui20>(&arg0.id, arg4), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, InscriptionSui20>(&mut arg0.id, arg4);
        arg0.total_inscription = arg0.total_inscription + 1;
        v0.current_mint = v0.current_mint + 1;
        assert!(v0.current_mint <= v0.max, 0);
        let v1 = Sui20MintEvent{
            tick         : arg4,
            current_mint : v0.current_mint,
        };
        0x2::event::emit<Sui20MintEvent>(v1);
        let v2 = InscribeEvent{
            inscription_id : arg0.total_inscription,
            object_id      : arg3,
        };
        0x2::event::emit<InscribeEvent>(v2);
        let v3 = InscriptionItem{
            inscription_id : arg0.total_inscription,
            inscription    : v0.inscription,
        };
        0x2::dynamic_field::add<0x2::object::ID, InscriptionItem>(&mut arg0.id, arg3, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun update_fee(arg0: &mut Fee, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 0);
        arg0.inscribe_sui20_fee = arg1;
        arg0.inscribe_fee = arg2;
    }

    public entry fun withdraw_sui(arg0: &mut Fee, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

