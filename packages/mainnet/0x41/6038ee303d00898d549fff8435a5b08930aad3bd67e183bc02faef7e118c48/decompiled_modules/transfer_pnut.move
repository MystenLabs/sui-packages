module 0x416038ee303d00898d549fff8435a5b08930aad3bd67e183bc02faef7e118c48::transfer_pnut {
    public fun transfer_object_with_borrowing<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

