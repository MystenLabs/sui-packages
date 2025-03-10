module 0xa7e2bc1ecf5e6a144c4774c37357ef244b0d721130ef1a40d14a996bdb58d1ef::pumpkin_voucherv1 {
    struct PumpkinVoucher has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        voucher_id: 0x1::string::String,
        redeemed: bool,
        expiration: 0x1::option::Option<u64>,
        creator: address,
    }

    struct VoucherCreated has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        voucher_id: 0x1::string::String,
        creator: address,
    }

    struct VoucherRedeemed has copy, drop {
        object_id: 0x2::object::ID,
        voucher_id: 0x1::string::String,
        redeemer: address,
    }

    struct PUMPKIN_VOUCHERV1 has drop {
        dummy_field: bool,
    }

    public fun creator(arg0: &PumpkinVoucher) : address {
        arg0.creator
    }

    public fun expiration(arg0: &PumpkinVoucher) : &0x1::option::Option<u64> {
        &arg0.expiration
    }

    fun init(arg0: PUMPKIN_VOUCHERV1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PUMPKIN_VOUCHERV1>(arg0, arg1);
        let v1 = 0x2::display::new<PumpkinVoucher>(&v0, arg1);
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"image"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"voucher_id"), 0x1::string::utf8(b"{voucher_id}"));
        0x2::display::add<PumpkinVoucher>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://pumpkin-vouchers.example"));
        0x2::display::update_version<PumpkinVoucher>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PumpkinVoucher>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_redeemed(arg0: &PumpkinVoucher) : bool {
        arg0.redeemed
    }

    public entry fun mint_voucher(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!0x1::vector::is_empty<u8>(&arg0)) {
            if (!0x1::vector::is_empty<u8>(&arg1)) {
                if (!0x1::vector::is_empty<u8>(&arg2)) {
                    !0x1::vector::is_empty<u8>(&arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = PumpkinVoucher{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            voucher_id  : 0x1::string::utf8(arg3),
            redeemed    : false,
            expiration  : arg4,
            creator     : v1,
        };
        let v3 = VoucherCreated{
            object_id  : 0x2::object::id<PumpkinVoucher>(&v2),
            name       : 0x1::string::utf8(arg0),
            voucher_id : 0x1::string::utf8(arg3),
            creator    : v1,
        };
        0x2::event::emit<VoucherCreated>(v3);
        0x2::transfer::public_transfer<PumpkinVoucher>(v2, v1);
    }

    public entry fun redeem_voucher(arg0: &mut PumpkinVoucher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.redeemed, 0);
        if (0x1::option::is_some<u64>(&arg0.expiration)) {
            assert!(0x2::tx_context::epoch(arg1) <= *0x1::option::borrow<u64>(&arg0.expiration), 0);
        };
        arg0.redeemed = true;
        let v0 = VoucherRedeemed{
            object_id  : 0x2::object::id<PumpkinVoucher>(arg0),
            voucher_id : arg0.voucher_id,
            redeemer   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VoucherRedeemed>(v0);
    }

    public entry fun transfer_voucher(arg0: PumpkinVoucher, arg1: address) {
        0x2::transfer::public_transfer<PumpkinVoucher>(arg0, arg1);
    }

    public fun voucher_id(arg0: &PumpkinVoucher) : &0x1::string::String {
        &arg0.voucher_id
    }

    // decompiled from Move bytecode v6
}

