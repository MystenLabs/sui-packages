module 0xd6a39609a31aa524a2ecc5b5292d59fe1a39275b3bbf6df6a21734ec7f552979::slicker {
    struct SLICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLICKER>(arg0, 6, b"SLICKER", b"SCUM LICKER", x"244c49434b4552206973206120747275652073746f7279206f662061206d616e2077686f206368616e67656420686973206c69666520746f206265636f6d652072696368210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3551_bf7af222d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

