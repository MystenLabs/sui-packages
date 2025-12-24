module 0xebbccc0bce609e0eb4f82c72b0dcb1158325c2c99be2eb789c21232ce874e206::delayed_upgrades_and_locked_upgrade_content {
    public fun transfer_any_object<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

