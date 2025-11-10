module 0x9b49f0eacc70f2988905bcb5637ae896481723c6010e196bc5b93dc82d6abee2::encrypter {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x9b49f0eacc70f2988905bcb5637ae896481723c6010e196bc5b93dc82d6abee2::collectivo::AdminCap, arg2: &0x9b49f0eacc70f2988905bcb5637ae896481723c6010e196bc5b93dc82d6abee2::campaign::Campaign) {
        assert!(0x2::object::id_bytes<0x9b49f0eacc70f2988905bcb5637ae896481723c6010e196bc5b93dc82d6abee2::campaign::Campaign>(arg2) == arg0, 0);
    }

    // decompiled from Move bytecode v6
}

