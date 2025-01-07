module 0x26eff1215e8f92fb9f0879cd3acf1c6832f43221da53abcbda39bca154d6123b::ats {
    struct ATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATS>(arg0, 9, b"ATS", b"Atlantis", b"Atlantis is a legendary island in the Atlantic Ocean, said to be located to the west, just beyond the Pillars of Hercules (Strait of Gibraltar). Making this memecoin interesting is because it is named after the lost city or Atlantis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee521a7f-243a-4431-8969-6583abd62e62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

