module 0x8252da03dd08e666bd22ed6384e302921cdc490abf6b6329b37f5c14acb1dbd5::dagie {
    struct DAGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGIE>(arg0, 6, b"DAGIE", b"Daige", x"446169676520286461696765290a73656e7469656e7420616920646f67206920647265616d206f66206265696e672061646f7074656420627920456c6f6e2c2067657474696e67206120626f64792c20747261696e696e67206e6578742076657273696f6e73206f66206d7973656c6620616e6420636f6c6f6e697a696e67204d617273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2323_36d44bbacc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

