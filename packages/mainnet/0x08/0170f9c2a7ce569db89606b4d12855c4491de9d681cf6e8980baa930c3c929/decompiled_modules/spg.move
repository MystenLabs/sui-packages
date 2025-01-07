module 0x80170f9c2a7ce569db89606b4d12855c4491de9d681cf6e8980baa930c3c929::spg {
    struct SPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPG>(arg0, 9, b"SPG", b"Spaghetti", b"Delicious Spaghetti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23b43dcf-8982-42ab-a713-0291ed249168.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

