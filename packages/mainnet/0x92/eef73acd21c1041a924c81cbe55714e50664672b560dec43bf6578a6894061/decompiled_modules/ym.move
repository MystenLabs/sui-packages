module 0x92eef73acd21c1041a924c81cbe55714e50664672b560dec43bf6578a6894061::ym {
    struct YM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YM>(arg0, 9, b"YM", b"YOUNG MAN", b"YOUNG MAN is a dynamic cryptocurrency aimed at empowering young investors. It supports educational initiatives and promotes financial literacy, offering staking rewards and community-driven governance to foster sustainable growth and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee50311f-04b6-467d-b574-5821684d96d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YM>>(v1);
    }

    // decompiled from Move bytecode v6
}

