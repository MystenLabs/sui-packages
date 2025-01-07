module 0xbe27c17fca0e2520c7f9a792b2493ac54112647c20cbe4281754c7a151edc90d::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 9, b"BIO", b"Biowelt", b"We can save our Planet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5a043a9-cd48-4ef8-922b-e15758fad58f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

