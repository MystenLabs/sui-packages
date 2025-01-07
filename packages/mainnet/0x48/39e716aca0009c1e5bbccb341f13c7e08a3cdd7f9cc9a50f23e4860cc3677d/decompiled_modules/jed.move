module 0x4839e716aca0009c1e5bbccb341f13c7e08a3cdd7f9cc9a50f23e4860cc3677d::jed {
    struct JED has drop {
        dummy_field: bool,
    }

    fun init(arg0: JED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JED>(arg0, 6, b"JED", b"Jellyfish with damn", b"can you hear me ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/85e2b4f7bc75cebd51dff9d9aa3bc325_482cafef45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JED>>(v1);
    }

    // decompiled from Move bytecode v6
}

