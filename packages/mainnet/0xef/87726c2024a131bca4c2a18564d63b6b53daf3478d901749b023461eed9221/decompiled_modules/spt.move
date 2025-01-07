module 0xef87726c2024a131bca4c2a18564d63b6b53daf3478d901749b023461eed9221::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    struct TreasuryBurnedEvent has copy, drop, store {
        owner: address,
        treasury_id: address,
        name: vector<u8>,
    }

    public entry fun burn_cap(arg0: 0x2::coin::TreasuryCap<SPT>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryBurnedEvent{
            owner       : 0x2::tx_context::sender(arg1),
            treasury_id : 0x2::object::id_address<0x2::coin::TreasuryCap<SPT>>(&arg0),
            name        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<SPT>())),
        };
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPT>>(arg0);
        0x2::event::emit<TreasuryBurnedEvent>(v0);
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 9, b"SPT", b"SPT", b"Seapad launchpad foundation token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1685439392353.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, @0xdd0106a909560b8f2e0262e9946008e307ae7758fde5277853088d25b0b6c7f);
    }

    // decompiled from Move bytecode v6
}

