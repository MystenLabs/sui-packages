module 0xe2beb4da2eeade2dd6d0c2ff17e5211ac2aecad2ee5ba0614eec89e083f0c1e3::sclown {
    struct SCLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCLOWN>(arg0, 6, b"SClown", b"clown", b"Send the clown to the moon together.Let's send the clown to the moon and build a better meme environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012739_35ee6148a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

