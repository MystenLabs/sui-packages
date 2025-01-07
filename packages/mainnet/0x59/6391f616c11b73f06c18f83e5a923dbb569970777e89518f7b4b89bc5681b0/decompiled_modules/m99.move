module 0x596391f616c11b73f06c18f83e5a923dbb569970777e89518f7b4b89bc5681b0::m99 {
    struct M99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M99>(arg0, 9, b"M99", b"mele", b"nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a187db3e-85f5-4459-a6c8-71c646ec04b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M99>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M99>>(v1);
    }

    // decompiled from Move bytecode v6
}

