module 0x9a3fbf3395600c9f3adb8b41b2fa29f27a42092fe184c8ebc273f0cfd8239655::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"Sui Diddy", b"Introducing DIDDY, the memecoin that's all about fun and community! With the playful spirit of \"I'm Diddy and ya are my son,\" we're here to create a vibrant ecosystem where everyone feels like family", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_131011_45fa0c0b52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

