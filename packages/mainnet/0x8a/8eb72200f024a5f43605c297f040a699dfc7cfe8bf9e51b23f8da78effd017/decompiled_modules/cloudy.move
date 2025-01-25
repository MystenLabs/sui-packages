module 0x8a8eb72200f024a5f43605c297f040a699dfc7cfe8bf9e51b23f8da78effd017::cloudy {
    struct CLOUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDY>(arg0, 9, b"cloudy", b"cloudyheart", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWtXVb38JHE141KGP3GLQhZCJvEmjahLF4Jg7m9UfM1ZC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLOUDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOUDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

