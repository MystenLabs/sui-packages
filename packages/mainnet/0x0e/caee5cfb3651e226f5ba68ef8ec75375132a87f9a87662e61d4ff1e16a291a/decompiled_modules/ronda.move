module 0xecaee5cfb3651e226f5ba68ef8ec75375132a87f9a87662e61d4ff1e16a291a::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"RONDA ON SUI", b"Meet Ronda. The First Billion Dollar Dog On Sui! We aim to create a vibrant community around Ronda, where investors can learn, share, and invest in our meme coin project while enjoying the playful spirit of Ronda and her adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ronda_8222eb8f55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

