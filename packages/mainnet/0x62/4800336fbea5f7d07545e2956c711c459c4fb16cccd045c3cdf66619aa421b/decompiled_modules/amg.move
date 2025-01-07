module 0x624800336fbea5f7d07545e2956c711c459c4fb16cccd045c3cdf66619aa421b::amg {
    struct AMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMG>(arg0, 9, b"AMG", b"AMG token", b"The next BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04dab700-4451-4241-8ffa-1e599adb354e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

