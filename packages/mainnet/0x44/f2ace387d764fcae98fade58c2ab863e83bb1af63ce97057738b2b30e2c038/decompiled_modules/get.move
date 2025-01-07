module 0x44f2ace387d764fcae98fade58c2ab863e83bb1af63ce97057738b2b30e2c038::get {
    struct GET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GET>(arg0, 9, b"GET", b"Gaint Elephant ", b"Gaint Elephant inu token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.gemoo.com/share/image-annotation/593687212675104768?codeId=PYxo4yXLp7VrL&origin=imageurlgenerator&card=593687211068690432")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GET>(&mut v2, 2500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GET>>(v1);
    }

    // decompiled from Move bytecode v6
}

