module 0xcec41f906056b1b2dd25dbb7c817a6db8004703bc07c2b4838806c31729cc733::mott {
    struct MOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTT>(arg0, 6, b"MOTT", b"MOT T", b"MOTTTTTTT is the one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie556jewytizvz47jzizpsndiyw7ihqza3edrjw2mkwv6vhaq5n4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

