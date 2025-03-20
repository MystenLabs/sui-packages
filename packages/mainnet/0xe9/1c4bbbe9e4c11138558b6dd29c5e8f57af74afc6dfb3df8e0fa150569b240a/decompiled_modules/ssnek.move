module 0xe91c4bbbe9e4c11138558b6dd29c5e8f57af74afc6dfb3df8e0fa150569b240a::ssnek {
    struct SSNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSNEK>(arg0, 6, b"SSNEK", b"SUI SNEK", x"2a2a53756920536e656b20546865204d656d6520436f696e2054616b696e67204f766572207468652053756920426c6f636b636861696e2a2a0a0a53756920536e656b20697320746865206c6174657374206d656d6520636f696e2073656e736174696f6e2074686174277320736c6974686572696e672069747320776179206f6e746f205375692e20496e7370697265642062792074686520696e7465726e6574e2809973206c6f766520666f7220736e656b732c207468697320636f696e20656d626f646965732074686520706c617966756c2c20717569726b7920737069726974206f6620536e656b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742441014338.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSNEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSNEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

