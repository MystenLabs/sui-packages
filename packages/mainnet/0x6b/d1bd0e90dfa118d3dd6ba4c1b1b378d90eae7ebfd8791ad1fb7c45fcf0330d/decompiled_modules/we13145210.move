module 0x6bd1bd0e90dfa118d3dd6ba4c1b1b378d90eae7ebfd8791ad1fb7c45fcf0330d::we13145210 {
    struct WE13145210 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE13145210, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE13145210>(arg0, 9, b"WE13145210", b"qqq", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61f28f0b-5724-49bd-bf66-5d2af9026e53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE13145210>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE13145210>>(v1);
    }

    // decompiled from Move bytecode v6
}

