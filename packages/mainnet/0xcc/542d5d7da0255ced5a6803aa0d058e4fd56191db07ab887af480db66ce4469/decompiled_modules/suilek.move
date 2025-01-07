module 0xcc542d5d7da0255ced5a6803aa0d058e4fd56191db07ab887af480db66ce4469::suilek {
    struct SUILEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEK>(arg0, 6, b"SUILEK", b"Suilek Rata", x"5375696c656b2c20746865206d6f73742064616e6765726f75732067616e67737461206f6e20776562332068617320617272697665642c2077696c6c20796f7520666163652069743f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_190450104_989f453d4e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

