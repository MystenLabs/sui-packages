module 0xf4b5d8d4563373e6d0a9b11f8708e479489c9fea20262efa25e6deb5a7eb2259::nuc {
    struct NUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUC>(arg0, 6, b"NUC", b"NucleaoCoin", b"In an era marked by conflict, uncertainty, and geopolitical instability, one truth emerges: power defines survival. While traditional currencies falter under the weight of inflation, sanctions, and warfare, NucleoCoin rises as the ultimate symbol of strength, resilience, and inevitability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibp7zzhckx3qlobq6cvyi6xregscqn554owoxrhtgfczy6d7vov64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NUC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

