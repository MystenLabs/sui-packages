module 0x1fd4b9a85a05e4aef3ad3ae8aad5e92c0590f65dcbbaa9f04005ac9ff8f579c8::dolph {
    struct DOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPH>(arg0, 6, b"DOLPH", b"DOLPHY", b"DOLPHY ON SUI IS HERE TO SHAKE UP THE SUI ECOSYSTEM ! ROADMAP & SITE ARE BEING WORKED ON . DEV IS COOKIN' . Updates & Info will be posted in our social channels ! - ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5042c7ca_dd9a_461d_b922_b5a69085e938_modified_775beb2f76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

