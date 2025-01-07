module 0x7835455a8ddfc5901cdc40f2665e259801fbcf937529c75b7004a0dbe35727ab::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"INU", b"DOGINU", b"Meet $DOGINU, the closest relative to $DOG on the BTC network. A meme coin based on SUI with an ambitious mission: to reach the moon and beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1674784029487_85aa0b58febdd71098f8ace9c9d312d9_3d0a8479d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}

