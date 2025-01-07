module 0x604de29377862a2548e10d0502799b3c127e6e71b27345581b170e3b827be7f3::freezer {
    entry fun freeze_metadata<T0: store + key>(arg0: T0) {
        0x2::transfer::public_freeze_object<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

