module 0xd873a6ba3a733069fb67b157e3ae46cfa552f91f136894e8e490128e7b57883b::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 9, b"LUCE", b"Luce", x"546865205661746963616e2068617320756e7665696c656420746865206f6666696369616c206d6173636f74206f662074686520486f6c79205965617220323032353a204c75636520284974616c69616e20666f72204c69676874292e0a0a41726368626973686f7020466973696368656c6c61207361797320746865206d6173636f742077617320696e73706972656420627920746865204368757263682773206465736972652022746f206c697665206576656e2077697468696e2074686520706f702063756c7475726520736f2062656c6f766564206279206f757220796f7574682e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e67fb47d-867c-48b2-b92c-89cecc52b92b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

