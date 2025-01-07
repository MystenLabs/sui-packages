module 0x3163adafea72efdf08006987aae798a512b7e071335d99529fbab70a13ca04d2::sahu {
    struct SAHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHU>(arg0, 9, b"SAHU", b"Raja", b"Good smart looking londa handsome boy + thoda sa sweet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e745aea1-6cd5-426d-ba70-d988a739b015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

