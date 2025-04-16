module 0xbbbfaaecba2d67f49c77fd61c628288445f3460ae7b3ef1867729632f0352d1d::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 9, b"Paws", b"Getpawsed", b"For those that aren't eligible for the paws airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a66d46ef782ba4a486ed3fb1c1685c0ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

