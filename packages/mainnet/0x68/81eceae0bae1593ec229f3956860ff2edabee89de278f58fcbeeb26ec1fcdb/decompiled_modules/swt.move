module 0x6881eceae0bae1593ec229f3956860ff2edabee89de278f58fcbeeb26ec1fcdb::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 6, b"SWT", b"Suiweet", b"The sweetest of cats on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007706_07373d3ef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

