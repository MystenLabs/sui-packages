module 0x2fd447c627df68c8280476045ddd842de2b2be3ea0c2b217595c704a052b1a6e::sldr {
    struct SLDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLDR>(arg0, 9, b"SLDR", b"soldier", x"4d6f766520666f7277617264207769746820534f4c44494552204d656d65636f696e2c206120726573696c69656e7420616e64206469676e69666965642063727970746f63757272656e637920696e7370697265642062792074686520636f757261676520616e64206469736369706c696e65206f6620736f6c64696572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/273680a5-f82d-49eb-a95c-0697af06e77f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

