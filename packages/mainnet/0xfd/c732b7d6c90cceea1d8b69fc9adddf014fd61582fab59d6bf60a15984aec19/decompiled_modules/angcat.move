module 0xfdc732b7d6c90cceea1d8b69fc9adddf014fd61582fab59d6bf60a15984aec19::angcat {
    struct ANGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGCAT>(arg0, 9, b"ANGCAT", b"ANGRYCAT ", b"ANGRYCAT wewe inspired by original wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86dc1166-f285-4a2b-9d79-a82813b18308.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

