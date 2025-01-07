module 0x423298624d0112ab5afc636dbae81f8e5a52656957cb188d3a5f6e7ce13462f5::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 9, b"DEAD", b"DEADPOOL", x"f09f838ff09f838f2023536f6369616c46692023536f6369616c46692024415641582024434f5120244755525320244152454e412040436f71496e754176617820406e6f6368696c6c617661782040477572734f6e41564158202343727970746f202343727970746f63757272656e63792023626974636f696e20407065616368626974636f696e2040426974636f696e4d6167617a696e652040426974636f696e202347414d4943202347616d69634875622024474e4720406d7967616d69636871204067616d69636875622020f09f838ff09f838f20244241475920f09f838ff09f838f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/513e2310-48ad-4692-bfa5-5059602eb6ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

