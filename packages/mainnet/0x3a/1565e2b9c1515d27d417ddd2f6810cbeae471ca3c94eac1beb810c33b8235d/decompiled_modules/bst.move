module 0x3a1565e2b9c1515d27d417ddd2f6810cbeae471ca3c94eac1beb810c33b8235d::bst {
    struct BST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BST>(arg0, 9, b"BST", b"BrawlToken", b"Brawl Stars Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27594345-3553-4ce3-98dc-32bbbaee7ec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BST>>(v1);
    }

    // decompiled from Move bytecode v6
}

