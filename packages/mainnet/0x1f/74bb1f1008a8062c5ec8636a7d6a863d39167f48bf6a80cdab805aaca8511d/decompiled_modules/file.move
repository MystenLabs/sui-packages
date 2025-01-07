module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file {
    struct File has store, key {
        id: 0x2::object::UID,
        inner: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer,
    }

    public fun delete(arg0: File) {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::delete(unpack(arg0));
    }

    public(friend) fun new(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::Repository, arg1: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer, arg2: &mut 0x2::tx_context::TxContext) : File {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository::assert_version(arg0);
        File{
            id    : 0x2::object::new(arg2),
            inner : arg1,
        }
    }

    public fun borrow_chunk(arg0: &File, arg1: u64) : &vector<u8> {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::borrow_chunk(&arg0.inner, arg1)
    }

    public fun has_chunk(arg0: &File, arg1: u64) : bool {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::has_chunk(&arg0.inner, arg1)
    }

    public fun size(arg0: &File) : u64 {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::length(&arg0.inner)
    }

    public fun uid(arg0: &File) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut File) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unpack(arg0: File) : 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer::Buffer {
        let File {
            id    : v0,
            inner : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

