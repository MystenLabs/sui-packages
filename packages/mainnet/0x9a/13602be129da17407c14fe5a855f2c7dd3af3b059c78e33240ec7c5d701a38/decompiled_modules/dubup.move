module 0x9a13602be129da17407c14fe5a855f2c7dd3af3b059c78e33240ec7c5d701a38::dubup {
    struct DUBUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBUP>(arg0, 6, b"Dubup", b"Double up", b"You are my double up sucker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbiifwv3ypoz3l4qqaf2lun47jw4c2lybeulz5sdy6wv7jgk4gaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUBUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

