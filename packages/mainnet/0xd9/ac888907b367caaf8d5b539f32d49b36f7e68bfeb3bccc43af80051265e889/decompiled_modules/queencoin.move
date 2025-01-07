module 0xd9ac888907b367caaf8d5b539f32d49b36f7e68bfeb3bccc43af80051265e889::queencoin {
    struct QUEENCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEENCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEENCOIN>(arg0, 9, b"QUEENCOIN", b"Queen", x"54686973206d656d6520636f696e2062656c6f6e677320746f206c6f76657273206f6620517565656e20456c697a61626574682e205769746820746865206372656174696f6e206f662074686973206d656d6520636f696e2c207765206172652072656d696e646564207468617420746865206c6f7665206f6620746865204772656174204272697469736820517565656e20697320696e2074686520686561727473206f66207468652070656f706c652e0a537570706f7274207468697320636f696e206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3476cb3-faaf-4700-974f-ca0ff0b98d48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEENCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUEENCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

