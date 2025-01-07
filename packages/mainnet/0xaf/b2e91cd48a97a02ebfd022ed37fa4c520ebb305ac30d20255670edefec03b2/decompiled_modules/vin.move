module 0xafb2e91cd48a97a02ebfd022ed37fa4c520ebb305ac30d20255670edefec03b2::vin {
    struct VIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIN>(arg0, 9, b"VIN", b"Vinti", b"Sui is always the best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f63afcee-507f-4833-a473-d60f1a0609cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

