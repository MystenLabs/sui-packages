module 0x17a3576861f0e0924b263a49ac698c9374f94c773b5f0f4a93232d90af6d261a::delayed_upgrades_and_locked_upgrade_content {
    public entry fun transfer_any_object<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

