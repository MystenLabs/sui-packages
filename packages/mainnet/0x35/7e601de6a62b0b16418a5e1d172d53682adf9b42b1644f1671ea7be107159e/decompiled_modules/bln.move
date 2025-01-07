module 0x357e601de6a62b0b16418a5e1d172d53682adf9b42b1644f1671ea7be107159e::bln {
    struct BLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLN>(arg0, 9, b"BLN", b"balon", x"5468652062756f79616e742063727970746f63757272656e63792074686174277320736f6172696e6720746f206e65772068656967687473f09f8e88", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66511594-e0d7-4ad7-88ff-0504a6313e7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

