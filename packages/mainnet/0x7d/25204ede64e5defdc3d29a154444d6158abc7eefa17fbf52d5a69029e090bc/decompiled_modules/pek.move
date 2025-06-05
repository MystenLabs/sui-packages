module 0x7d25204ede64e5defdc3d29a154444d6158abc7eefa17fbf52d5a69029e090bc::pek {
    struct PEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEK>(arg0, 6, b"Pek", b"pekchu", b"pekchu is gud Pokman he havs gud skell and eloctrec powars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicllophjutefyenbyzqsxqoc4euxetrxezdifcpxi5glf3gqcnbj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

