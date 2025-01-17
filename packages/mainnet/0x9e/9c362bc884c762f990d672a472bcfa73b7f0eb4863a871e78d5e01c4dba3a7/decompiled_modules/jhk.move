module 0x9e9c362bc884c762f990d672a472bcfa73b7f0eb4863a871e78d5e01c4dba3a7::jhk {
    struct JHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHK>(arg0, 6, b"JHK", b"JHK", b"The JHK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-402yKKx5KVGJ5-dfcuy3vhobYmE3olbxZA&s"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JHK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

