module 0x72546b52eaad1411874cb09a39185c010083843c76b9dbdbf59fc89c9a3ab541::qqq777 {
    struct QQQ777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ777>(arg0, 9, b"QQQ777", b"QQQ77777", b"I like being here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/98a005af4e38204b14d9c4148c456d27blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ777>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ777>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

