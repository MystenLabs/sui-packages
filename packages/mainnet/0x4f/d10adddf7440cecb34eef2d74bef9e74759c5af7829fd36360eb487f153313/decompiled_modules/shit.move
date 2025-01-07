module 0x4fd10adddf7440cecb34eef2d74bef9e74759c5af7829fd36360eb487f153313::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"Shit", b"Shitcoin on SUI", b"Its nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732632952533.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

