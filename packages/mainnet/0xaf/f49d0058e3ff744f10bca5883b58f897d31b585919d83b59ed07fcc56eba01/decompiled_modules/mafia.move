module 0xaff49d0058e3ff744f10bca5883b58f897d31b585919d83b59ed07fcc56eba01::mafia {
    struct MAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIA>(arg0, 6, b"Mafia", b"SuiMafia", x"54686520756c74696d61746520535549206d656d6520636f696e207768657265206c6f79616c7479206d65657473206f70706f7274756e69747921204a6f696e20612076696272616e7420636f6d6d756e697479207468617420626c656e64732066756e20776974682066696e616e63652c20696e7370697265642062792074686520776f726c64206f66206f7267616e697a6564206372696d652e205769746820537569204d616669612c20796f75e280997265206e6f74206a75737420696e76657374696e673b20796f75e280997265206a6f696e696e6720612066616d696c790a0ae28094206e6f206f6666657273207265667573656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733702635434.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAFIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

