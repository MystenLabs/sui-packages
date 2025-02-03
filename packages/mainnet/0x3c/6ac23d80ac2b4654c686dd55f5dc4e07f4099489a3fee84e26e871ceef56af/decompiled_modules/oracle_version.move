module 0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_version {
    public fun next_version() : u64 {
        0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_constants::version(), 0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

