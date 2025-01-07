module 0x267708ffb71331b63cad362e1dd24a36805e53d93ae616c2124c576847ba2a8b::jf {
    struct JF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JF>(arg0, 6, b"JF", b"JellyFish", b"A jelly fish  in the waters of the sui ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000118420_cca0398fde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JF>>(v1);
    }

    // decompiled from Move bytecode v6
}

