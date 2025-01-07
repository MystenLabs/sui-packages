module 0xb70c14f0afee78ed5b415d773547f322e408f2b34766e9b79acb081dd919c847::bst {
    struct BST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BST>(arg0, 6, b"BST", b"Bart Simpson Stoned", x"596f75277265206e6f742072656164792c20776527726520676f696e6720746f206d656c742066616365732e0a50726f6261626c79206e6f7468696e672e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731489864803.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

