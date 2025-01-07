module 0x285a9c795743225072a1861cffd382cb4b1608f0951c5859616ae57cad83375a::spm {
    struct SPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPM>(arg0, 9, b"SPM", b"Supermon", b"Top1sever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1073166-653f-4475-8bcd-5450293393f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

