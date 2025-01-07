module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::uninit_file {
    struct UninitFile has store, key {
        id: 0x2::object::UID,
        integrity: vector<u8>,
        content_length: u64,
        fees: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::Fees,
        inner: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer,
    }

    public fun empty(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::Repository, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : UninitFile {
        let v0 = 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::new(arg3);
        new(arg0, arg1, arg2, v0, arg3)
    }

    public fun delete(arg0: UninitFile) {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::delete(unpack(arg0));
    }

    fun new(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::Repository, arg1: vector<u8>, arg2: u64, arg3: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer, arg4: &mut 0x2::tx_context::TxContext) : UninitFile {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::assert_version(arg0);
        UninitFile{
            id             : 0x2::object::new(arg4),
            integrity      : arg1,
            content_length : arg2,
            fees           : *0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::fees(arg0),
            inner          : arg3,
        }
    }

    public fun borrow_chunk(arg0: &UninitFile, arg1: u64) : &vector<u8> {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::borrow_chunk(&arg0.inner, arg1)
    }

    public fun has_chunk(arg0: &UninitFile, arg1: u64) : bool {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::has_chunk(&arg0.inner, arg1)
    }

    public entry fun reset(arg0: &mut UninitFile, arg1: vector<u8>, arg2: u64) {
        arg0.integrity = arg1;
        arg0.content_length = arg2;
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::reset(&mut arg0.inner, arg2);
    }

    public entry fun truncate(arg0: &mut UninitFile, arg1: u64) {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::truncate(&mut arg0.inner, arg1);
    }

    public entry fun write(arg0: &mut UninitFile, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::length(&arg0.inner), 1);
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::pay(&arg0.fees, 0x1::vector::length<u8>(&arg2), 0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg4);
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::write(&mut arg0.inner, arg2);
    }

    fun unpack(arg0: UninitFile) : 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer {
        let UninitFile {
            id             : v0,
            integrity      : _,
            content_length : _,
            fees           : _,
            inner          : v4,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    public fun from_file(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::Repository, arg1: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : UninitFile {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::assert_version(arg0);
        new(arg0, arg2, 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::size(&arg1), 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::unpack(arg1), arg3)
    }

    public fun into_file(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::Repository, arg1: UninitFile, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::assert_version(arg0);
        assert!(&arg1.integrity == &arg2, 0);
        assert!(arg1.content_length == arg3, 1);
        assert!(arg1.content_length == 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::length(&arg1.inner), 2);
        let v0 = 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::new(arg0, unpack(arg1), arg4);
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::metadata_integrity::set(&mut v0, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

