module 0xb42dbb7413b79394e1a0175af6ae22b69a5c7cc5df259cd78072b6818217c027::kiosk_listings {
    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Listing<T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: 0x2::coin::Coin<0x2::sui::SUI>,
        beneficiary: address,
    }

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun unlist<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

