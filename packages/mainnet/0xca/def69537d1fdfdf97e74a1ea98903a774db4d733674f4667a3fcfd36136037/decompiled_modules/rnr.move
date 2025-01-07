module 0xcadef69537d1fdfdf97e74a1ea98903a774db4d733674f4667a3fcfd36136037::rnr {
    struct RNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNR>(arg0, 9, b"RNR", b"RockNRoll", b"Rock on Buddy!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14d02c0a-4d9c-4b6d-b696-87fd8b3c9407.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

