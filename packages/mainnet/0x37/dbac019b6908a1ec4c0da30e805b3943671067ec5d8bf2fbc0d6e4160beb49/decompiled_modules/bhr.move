module 0x37dbac019b6908a1ec4c0da30e805b3943671067ec5d8bf2fbc0d6e4160beb49::bhr {
    struct BHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHR>(arg0, 9, b"BHR", b"BOWHNTER", b"BOWHUNTER IS HUNTING WITH HIS BOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fc4e9ab-37f9-4e8d-9ecf-5c0145a273d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

