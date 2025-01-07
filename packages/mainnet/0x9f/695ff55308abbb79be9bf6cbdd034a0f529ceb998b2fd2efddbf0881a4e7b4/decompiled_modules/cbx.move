module 0x9f695ff55308abbb79be9bf6cbdd034a0f529ceb998b2fd2efddbf0881a4e7b4::cbx {
    struct CBX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBX>(arg0, 9, b"CBX", b"Coinbrix ", x"5468697320636f696e2069732064656469636174656420746f20746865207374727567676c65206f66206e6577626965e280997320747279696e6720746f20616363756d756c6174652061206865616c7468792063727970746f63757272656e637920706f7274666f6c696f2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4049e6fa-ac61-48b6-9088-532317b32a1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBX>>(v1);
    }

    // decompiled from Move bytecode v6
}

