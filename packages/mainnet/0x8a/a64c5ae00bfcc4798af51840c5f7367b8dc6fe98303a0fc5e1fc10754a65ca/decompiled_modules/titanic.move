module 0x8aa64c5ae00bfcc4798af51840c5f7367b8dc6fe98303a0fc5e1fc10754a65ca::titanic {
    struct TITANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANIC>(arg0, 9, b"TITANIC", b"RSMTitanic", b"Titanic is a 1997 American epic romantic disaster film directed, written, co-produced and co-edited by James Cameron.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bc5f537-3c3e-416a-84ba-7915a8eb4bc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

