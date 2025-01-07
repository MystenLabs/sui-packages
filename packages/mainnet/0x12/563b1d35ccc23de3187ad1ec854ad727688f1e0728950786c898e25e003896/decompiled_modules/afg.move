module 0x12563b1d35ccc23de3187ad1ec854ad727688f1e0728950786c898e25e003896::afg {
    struct AFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFG>(arg0, 9, b"AFG", b"KGR", b"Good morning I hope ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4406b8eb-c3af-4035-9b9a-1d9c26dbe226.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

