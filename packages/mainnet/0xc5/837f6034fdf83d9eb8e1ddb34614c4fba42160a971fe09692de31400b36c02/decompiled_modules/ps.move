module 0xc5837f6034fdf83d9eb8e1ddb34614c4fba42160a971fe09692de31400b36c02::ps {
    struct PS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS>(arg0, 6, b"PS", b"Popkins x SUI", b"Let your imagination Saur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiah4biojkiqtyubyufotleqecj7lx3i6jtnbrfutmo5euhiosl3ti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

