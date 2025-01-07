module 0x94f6d15784424dad3ceb67f575576d9daae975a4001bd7f061e5541704c508e::nmk {
    struct NMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMK>(arg0, 9, b"NMK", b"Namek", b"The most efficient solutions for web3. Update your score level. DBZ MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/937aebf5-f6b1-4644-a85c-8ab09d36cee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

