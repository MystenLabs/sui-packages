module 0x5ad34c7ae127d15d5f476d0ff02819c985f85253fd735bbd49a16afd8e531732::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Sui Coin Flip", b"Meme coin+Coin Flip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coins_flip_96fac0d2e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

